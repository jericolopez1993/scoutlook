class AddEmailSignatureToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :email_signature, :text, :default => <<END_SIGNATURE
    <table class="m_-3783900543240753759MsoNormalTable" style="color: #222222; font-family: Arial, Helvetica, sans-serif; font-size: small; border-collapse: collapse;" border="0" cellspacing="0" cellpadding="0">
      <tbody>
        <tr style="height: 72.55pt;">
          <td style="font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; margin: 0px; width: 126.15pt; border-top: none; border-bottom: none; border-left: none; border-image: initial; border-right: 1pt solid red; padding: 0cm 5.4pt; height: 72.55pt;" valign="top" width="168">
            <table class="m_-3783900543240753759MsoNormalTable" style="width: 116.1pt;" border="0" width="155" cellspacing="0" cellpadding="0">
              <tbody>
                <tr style="height: 13.3pt;">
                  <td style="font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; margin: 0px; width: 116.1pt; padding: 0cm; height: 13.3pt;" width="155">
                    <p class="MsoNormal" style="margin: 0px; text-align: center;" align="center"><strong><span style="font-size: 14pt; font-family: Arial, sans-serif; color: black;">{{Full Name}}</span></strong><u></u><u></u></p>
                  </td>
                </tr>
                <tr style="height: 7pt;">
                  <td style="font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; margin: 0px; width: 116.1pt; padding: 0cm; height: 7pt;" width="155">
                    <p class="MsoNormal" style="margin: 0px;"><strong><span style="font-size: 5pt; font-family: Arial, sans-serif; color: black;">&nbsp;</span></strong><u></u><u></u></p>
                  </td>
                </tr>
                <tr style="height: 43.7pt;">
                  <td style="font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; margin: 0px; width: 116.1pt; padding: 0cm; height: 43.7pt;" width="155">
                    <p class="MsoNormal" style="margin: 0px; text-align: center; line-height: 14.95px;" align="center"><a style="color: #1155cc;" href="http://scoutlogistics.com/" target="_blank" rel="noopener" data-saferedirecturl="https://www.google.com/url?q=http://scoutlogistics.com/&amp;source=gmail&amp;ust=1552317655498000&amp;usg=AFQjCNFbnVmtYqeDo0aN1UsYBjs8QtKT5Q"><span style="color: windowtext; text-decoration-line: none;"><img id="m_-3783900543240753759Picture_x0020_1" class="CToWUd" style="width: 140px;" src="https://scoutlogistics.com/images/logo.png" alt="scout.png" border="0" data-image-whitelisted="" /></span></a><u></u><u></u></p>
                  </td>
                </tr>
              </tbody>
            </table>
          </td>
          <td style="font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; margin: 0px; width: 227.3pt; padding: 0cm 5.4pt; height: 72.55pt;" colspan="2" valign="top" width="303">
            <table class="m_-3783900543240753759MsoNormalTable" style="width: 215.65pt;" border="0" width="288" cellspacing="0" cellpadding="0">
              <tbody>
                <tr style="height: 11.65pt;">
                  <td style="font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; margin: 0px; width: 215.65pt; padding: 0cm; height: 11.65pt;" width="288">
                    <p class="MsoNormal" style="margin: 0px; line-height: 14.95px;"><strong><span style="font-size: 9pt; line-height: 13.8px; font-family: Arial, sans-serif; color: black;">{{Title}}</span></strong><u></u><u></u></p>
                  </td>
                </tr>
                <tr style="height: 12.5pt;">
                  <td style="font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; margin: 0px; width: 215.65pt; padding: 0cm; height: 12.5pt;" width="288">
                    <p class="MsoNormal" style="margin: 0px; line-height: 14.95px;"><strong><span style="font-size: 9pt; line-height: 13.8px; font-family: Arial, sans-serif; color: black;">Scout Logistics Corporation<u></u><u></u></span></strong></p>
                  </td>
                </tr>
                <tr style="height: 3.9pt;">
                  <td style="font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; margin: 0px; width: 215.65pt; padding: 0cm; height: 3.9pt;" width="288">
                    <p class="MsoNormal" style="margin: 0px; line-height: 14.95px;"><span style="font-size: 3pt; line-height: 4.6px; font-family: Arial, sans-serif; color: black;">&nbsp;</span><u></u><u></u></p>
                  </td>
                </tr>
                <tr style="height: 32.8pt;">
                  <td style="font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; margin: 0px; width: 215.65pt; padding: 0cm; height: 32.8pt;" width="288">
                    <p class="MsoNormal" style="margin: 0px; line-height: 14.95px;"><strong><span style="font-size: 8pt; line-height: 12.2667px; font-family: Arial, sans-serif; color: black;">Phone:</span></strong><span style="font-size: 8pt; line-height: 12.2667px; font-family: Arial, sans-serif; color: black;">&nbsp;{{Phone}}<u></u><u></u></span></p>
                    <p class="MsoNormal" style="margin: 0px; line-height: 14.95px;"><strong><span style="font-size: 8pt; line-height: 12.2667px; font-family: Arial, sans-serif; color: black;">Direct</span></strong><span style="font-size: 8pt; line-height: 12.2667px; font-family: Arial, sans-serif; color: black;">: {{Direct}}<u></u><u></u></span></p>
                    <p class="MsoNormal" style="margin: 0px; line-height: 14.95px;"><strong><span style="font-size: 8pt; line-height: 12.2667px; font-family: Arial, sans-serif; color: black;">Toll Free:</span></strong><span style="font-size: 8pt; line-height: 12.2667px; font-family: Arial, sans-serif; color: black;">&nbsp;{{Toll Free}}<u></u><u></u></span></p>
                    <p class="MsoNormal" style="margin: 0px; line-height: 14.95px;"><strong><span style="font-size: 8pt; line-height: 12.2667px; font-family: Arial, sans-serif; color: black;">Cell:</span></strong><span style="font-size: 8pt; line-height: 12.2667px; font-family: Arial, sans-serif; color: black;">&nbsp;{{Cell}}<u></u><u></u></span></p>
                  </td>
                </tr>
                <tr>
                  <td style="font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; margin: 0px; width: 215.65pt; padding: 0cm;" width="288">&nbsp;</td>
                </tr>
                <tr style="height: 10.9pt;">
                  <td style="font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; margin: 0px; width: 215.65pt; padding: 0cm; height: 10.9pt;" width="288">
                    <p class="MsoNormal" style="margin: 0px; line-height: 14.95px;"><a style="color: #1155cc;" href="mailto:" target="_blank" rel="noopener"><span style="font-size: 8pt; line-height: 12.2667px; font-family: Arial, sans-serif; color: blue;">{{E-Mail Address}}</span></a><u></u><u></u></p>
                  </td>
                </tr>
              </tbody>
            </table>
          </td>
        </tr>
        <tr style="height: 43.7pt;">
          <td style="font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; margin: 0px; width: 344.25pt; border-right: none; border-bottom: none; border-left: none; border-image: initial; border-top: 1pt solid red; padding: 0cm 5.4pt; height: 43.7pt;" colspan="2" width="459">
            <p class="MsoNormal" style="margin: 0px;">&nbsp;
              <a style="color: #1155cc;" href="https://www.bestmanagedcompanies.ca/en/Pages/Home.aspx" target="_blank" rel="noopener" data-saferedirecturl="https://www.google.com/url?q=https://www.bestmanagedcompanies.ca/en/Pages/Home.aspx&amp;source=gmail&amp;ust=1552317655498000&amp;usg=AFQjCNEr8SxfsYq20EXSAi98sbF7nmyQ5g">
              <span style="color: windowtext; text-decoration-line: none;">
              <img id="m_-3783900543240753759Picture_x0020_3" class="CToWUd" style="width: 120px; height: 50px;" src="https://openroadhyundairichmond.com/sites/default/files/styles/scale_width_1280/public/assets/blog_post/hero/2019-01/bestmanaged.jpg?itok=t9OECK-I" alt="deloitt" width="94" height="38" border="0" data-image-whitelisted="" /></span></a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              <a style="color: #1155cc;" href="http://bridlebash.org/" target="_blank" rel="noopener" data-saferedirecturl="https://www.google.com/url?q=http://bridlebash.org/&amp;source=gmail&amp;ust=1552317655498000&amp;usg=AFQjCNEfAlXJNFkmz9fIis3Uk4fCiUtgug">
              <span style="color: windowtext; text-decoration-line: none;">
              <img id="m_-3783900543240753759Picture_x0020_4" class="CToWUd" style="width: 120px; height: 50px;" src="https://mms.businesswire.com/media/20160912005699/en/543482/4/Bridle_Bash_Logo_%282%29.jpg" alt="bridlebash" width="105" height="43" border="0" data-image-whitelisted="" /></span></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              <a style="color: #1155cc;" href="https://www.facebook.com/pages/Scout-Logistics/194502150588319" target="_blank" rel="noopener" data-saferedirecturl="https://www.google.com/url?q=https://www.facebook.com/pages/Scout-Logistics/194502150588319&amp;source=gmail&amp;ust=1552317655498000&amp;usg=AFQjCNHNRrVAjgjPX_9bp205GTH4iHxpWQ">
              <span style="color: windowtext; text-decoration-line: none;">
              <img id="m_-3783900543240753759Picture_x0020_5" class="CToWUd" style="width: 0.3541in; height: 0.3541in;" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOEAAADhCAMAAAAJbSJIAAAAaVBMVEU6VZ////81Up0yT5xgc61+jbsvTZyXo8hFXaOirM0nSJmlrs7O1OUkRpkfQ5doerLr7fTHzeE9WKHV2umHlcDy9Pnd4eyut9O1vtdZbat5ibmWoceGk7/M0eSrs9G/xtxMY6ZvgLVIYaWJ8OFBAAAC40lEQVR4nO3c63KqMBRAYU9iqaLg/d7W2vd/yE5nzt/ihjTsvTNrPQDDNxIDJDqZEBERERERERERERERERFZL4QYqydF7ZMcXKyadju97m/zzhZ7n8SqCY/T8Z+kXa19sv2LdbztRLqflu6EsXm8i3kOhbF9WffxeROG9tHT50xYbTd9fb6E7Vt/nydhqO9DgH6EcdZ7BPoSVpdhPjfCajUU6EQYhwN9COPncKALYdgeChe2socIv8LmnAJ0IIzXJKADYZMyCD0IE69R+8Iw+F7Gi7CVv67wKQzTVKB1YbMsXBhSbtdcCOtT6cLUudC8MD7SgbaFdepsb17YDHw140YYZn8ANC2M+78QWl57qvoMw8PuvHC3fljL70k3q7qu/a0Bt9LZ8HhpgvbJDioKgffWp28SvqRA7TMdmvDJ6egWKBV+Ob1EJ1LhyfB09yyZ0PFHKBMeG+3TTEgkPFXap5mQSGj5nuxpIuELQsshRGg/hAjthxCh/RAitB9ChPZDiNB+CBHarwxh6PiJci3ZWnptnv3SWRm4ev2920IgPN86jvDTfKsqrD4EiMR0V98qyceU1kF3iXgEofLy2wjCe/FX6Yful+kIwn3xwpXuOv8Iws/ihcr3NPmFa+UdU/mFS+XdKPmFZ+UtU/mFr8WPQ+3nx/zCi/K2t/xC7VcA2YUH7b2Z2YXqWxezCzfFf4bqmzOzC2/Ff9M8ihdqT4f5hdrDMLtQ+VXiCEL93x7mFiq/ShxBOC9+HL5pTxbZhVPtySK7UNuXXXhQH4a5hWvtZ6fswnf1ySL3GvBZ/yqdbGcdSf4O8q3rCLpL+P8LvxdFu02qjiNo455Vxn6arhAitB9ChPZDiNB+CBHaDyFC+yFEaD+ECO2HEKH9ECK0H0KE9kOI0H4IEdoPIUL7IURoP4QI7YcQof0QIrQfQoT2Q4jQfggR2g8hQvshRGg/hAjthxCh/RAitB9ChPZDiNB+CBH26BsaQkVVLImVewAAAABJRU5ErkJggg==" alt="facebook" width="34" height="34" border="0" data-image-whitelisted="" /></span></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              <a style="color: #1155cc;" href="https://www.linkedin.com/company/scout-logistics-corporation?trk=company_logo" target="_blank" rel="noopener" data-saferedirecturl="https://www.google.com/url?q=https://www.linkedin.com/company/scout-logistics-corporation?trk%3Dcompany_logo&amp;source=gmail&amp;ust=1552317655498000&amp;usg=AFQjCNGV6B5fwhVVDd_D9cKRhP4YXrsI0w">
              <span style="color: windowtext; text-decoration-line: none;">
              <img id="m_-3783900543240753759Picture_x0020_6" class="CToWUd" style="width: 0.3541in; height: 0.3541in;" src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBdyMXpSBhckZFZI5kiArYAj4g-ZqXvjCrKWzy8WqtHchR0e64" alt="linkedin" width="34" height="34" border="0" data-image-whitelisted="" /></span></a>&nbsp;&nbsp;
              <wbr />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              <a style="color: #1155cc;" href="http://www.twitter.com/scoutlogistics/" target="_blank" rel="noopener" data-saferedirecturl="https://www.google.com/url?q=http://www.twitter.com/scoutlogistics/&amp;source=gmail&amp;ust=1552317655498000&amp;usg=AFQjCNHNp7s0zkxV-wsGpoM7nLGCbmTLFw">
              <span style="color: windowtext; text-decoration-line: none;">
              <img id="m_-3783900543240753759Picture_x0020_7" class="CToWUd" style="width: 0.3541in; height: 0.3541in;" src="https://cdn3.iconfinder.com/data/icons/inficons/512/twitter.png" alt="twitter" width="34" height="34" border="0" data-image-whitelisted="" /></span></a><u></u><u></u></p>
          </td>
          <td style="font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; margin: 0px; width: 9.25pt; padding: 0cm; height: 43.7pt;" width="12">
            <p class="MsoNormal" style="margin: 0px;">&nbsp;<u></u><u></u></p>
          </td>
        </tr>
        <tr style="height: 24.2pt;">
          <td style="font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; margin: 0px; width: 344.25pt; padding: 0cm 5.4pt; height: 24.2pt;" colspan="2" width="459">
            <p class="MsoNormal" style="margin: 0px; text-align: center;" align="center"><span style="font-size: 8pt; font-family: Arial, sans-serif; color: #943634;">"The one thing that doesn't abide by majority rule is a person's conscience."<u></u><u></u></span></p>
            <p class="MsoNormal" style="margin: 0px; text-align: center;" align="center"><span style="font-size: 8pt; font-family: Arial, sans-serif; color: #943634;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<wbr /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - Atticus Finch "To Kill a Mocking Bird"</span></p>
          </td>
        </tr>
      </tbody>
    </table>
END_SIGNATURE
  end
end
