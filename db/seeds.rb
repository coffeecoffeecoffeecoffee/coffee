coffee_group = FactoryBot.create(:group, name: 'SF iOS Coffee')
beer_group = FactoryBot.create(:group, name: 'SF iOS Beer')

FactoryBot.create_list(:event, 2, group: coffee_group)
FactoryBot.create_list(:event, 2, group: beer_group)
