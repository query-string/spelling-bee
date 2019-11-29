class DinctionaryService
  def self.call(word)
    url = "https://www.dictionaryapi.com/api/v3/references/sd4/json/#{word}?key=#{ENV['DICTIONARY_API_KEY']}"

    begin
      response = HTTParty.get(url)
      response.success? ? response.parsed_response[0]["shortdef"] : []
    rescue HTTParty::Error
      []
    rescue StandardError
      []
    end
  end
end
