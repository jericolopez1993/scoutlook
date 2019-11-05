class MoveNotesServices
  def move
    @carriers  = Carrier.all
    @carrier_contacts  = CarrierContact.all
    notes = []

    @carriers.each do |carrier|
      if !carrier.notes.nil? && !carrier.notes.blank?
        notes.push({user_id: carrier.relationship_owner, carrier_id: carrier.id, notes: carrier.notes})
      end
    end
    @carrier_contacts.each do |cc|
      if !cc.notes.nil? && !cc.notes.blank?
        notes.push({user_id: cc.carrier.relationship_owner, carrier_id: cc.carrier_id, notes: cc.notes})
      end
    end

    CarrierNote.create(notes)
  end
end
