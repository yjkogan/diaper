module DiaperPartnerClient
  def self.post(path, attributes)
    diaper_partner_url = "http://diaperpartner.herokuapp.com" #ENV["DIAPER_PARTNER_URL"]
    return if diaper_partner_url.blank?

    partner = { partner:
      {diaper_bank_id: attributes["organization_id"],
      partner_id: attributes["id"],
      email: attributes["email"]
      }}

    uri = URI(diaper_partner_url + path)
    req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
    req.body = partner.to_json

    res = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(req)
    end
  end
end
