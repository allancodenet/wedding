class Provider < ApplicationRecord

    enum service: {
        venue: 0,
        photographer: 1,
        caterer: 2,
        decorator: 3,
        makeup: 4


    }
end
