require 'digest/sha2'

class PhotoBackend
    def self.fetch_random_photo
        uri = URI.parse('https://api.unsplash.com/photos/random?collections=8721950')

        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true

        request = Net::HTTP::Get.new(uri.request_uri)
        request['Authorization'] = 'Client-ID RPlqWvR29uihzuIM0So_ZqqgIkGNrIOxWx1xMIeClt0'

        response = http.request(request)

        if response.code.to_i == 200
        
            json_response = JSON.parse(response.body)
            url = json_response['urls']['raw']

            if url != nil
                return url
            end
        end
        return "https://images.unsplash.com/photo-1511884642898-4c92249e20b6"
    end

    def self.get_profile_proto(email)
        "https://gravatar.com/avatar/#{Digest::SHA256.hexdigest(email.downcase)}?d=https://i.pinimg.com/originals/bc%2F8f%2F29%2Fbc8f29c4183345bcc63bd4a161e88c71.png&s=500"
    end
end