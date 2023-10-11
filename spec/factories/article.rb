FactoryBot.define do 
	factory :article, class: "Article" do 
	  title { Faker::Name.unique.name }
	  bode { Faker::Name.unique.name }
	end
end
