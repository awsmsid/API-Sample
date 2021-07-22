# frozen_string_literal: true

class OCRSpaceService
  def self.upload(image_url)
    params = { language: 'eng',
               isOverlayRequired: true,
               iscreatesearchablepdf: false,
               issearchablepdfhidetextlayer: false,
               url: image_url }

    headers = { apikey: ENV['OCR_SPACE_API_KEY'] }

    response = RestClient.post ENV['OCR_SPACE_URL'], params, headers

    response.body
  end
end
