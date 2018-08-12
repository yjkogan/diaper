module DiaperPartnerClient
  def self.post(path, attributes)
    diaper_partner_url = "https://diapertesting.herokuapp.com/partners"
    return if diaper_partner_url.blank?

    partner = { partner:
      {diaper_bank_id: attributes["organization_id"],
      diaper_partner_id: attributes["id"],
      email: attributes["email"]
      }}

    uri = URI(diaper_partner_url + path)
    req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
    req.body = partner.to_json

    response = https(uri).request(req)

    response.body
  end

  def self.https(uri)
    Net::HTTP.new(uri.host, uri.port).tap do |http|
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end
  end
end
