class Provider < ApplicationRecord
    belongs_to :user
    has_many_attached :images
    enum service: {
        venue: 0,
        photographer: 1,
        caterer: 2,
        decorator: 3,
        makeup: 4
    }


    def resized_images
        images.map { |image| image.variant(resize_to_limit: [300, 300]).processed }
    end
    def show_images
        images.map { |image| image.variant(resize_to_limit: [1400, 800]).processed }
    end


end
