Rack::Attack.throttle('requests/ip', limit: 100, period: 1.minute) do |req|
    req.ip
end
Rack::Attack.safelist('allow from trusted IP') do |req|
    ['127.0.0.1'].include?(req.ip)
end

Rack::Attack.throttled_responder = lambda do |request|
    [ 503, {}, ["Rate limit exceeded. If this is in error please contace your designated healthcare professional.\n"]]
end