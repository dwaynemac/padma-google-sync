require 'gdata'

class GoogleContactsClient

  def initialize(username, password)
    @username = username
    @password = password

    @client = GData::Client::Contacts.new

    @client.clientlogin(@username,@password)
  end

  def create(first_name, last_name, email, phone)
    body = <<XML_BODY
<atom:entry xmlns:atom='http://www.w3.org/2005/Atom' xmlns:gd='http://schemas.google.com/g/2005'>
  <gd:name>
    <gd:givenName>#{first_name}</gd:givenName>
    <gd:familyName>#{last_name}</gd:familyName>
    <gd:fullName>#{last_name}, #{first_name}</gd:fullName>
  </gd:name>
  <atom:content type='text'>
    Notes
  </atom:content>
  <gd:phoneNumber rel='http://schemas.google.com/g/2005#home' primary='true'>
    #{phone}
  </gd:phoneNumber>
  <gd:email rel='http://schemas.google.com/g/2005#home' address='#{email}'/>
</atom:entry>
XML_BODY

    @client.post("https://www.google.com/m8/feeds/contacts/default/full?v=3.0 ", body )
  end

  def self.get(id="7f7945698cb8e91a")
    @client.get("https://www.google.com/m8/feeds/contacts/default/full/#{id}?v=3.0 ")
  end
end
