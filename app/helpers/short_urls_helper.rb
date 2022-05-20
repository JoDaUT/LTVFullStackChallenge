module ShortUrlsHelper
    CHARACTERS = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    def base62Encoder(id)
        short_url = ''
        while id > 0
            short_url += CHARACTERS[id % 62]
            id = id/62;
        end
        short_url.reverse!
        return short_url
    end

    def base62Decoder(short_url)
        id = 0
        for i in 0...short_url.length do
            if 'a'.ord <= short_url[i].ord && short_url[i].ord <= 'z'.ord
                id = id*62 + short_url[i].ord - 'a'.ord
            end
            if 'A'.ord <= short_url[i].ord && short_url[i].ord <= 'Z'.ord
                id = id*62 + short_url[i].ord - 'A'.ord + 26
            end
            if '0'.ord <= short_url[i].ord && short_url[i].ord <= '9'.ord
                id = id*62 + short_url[i].ord - '0'.ord + 52
            end
        end
	    
	    
	    return id
    end
end
