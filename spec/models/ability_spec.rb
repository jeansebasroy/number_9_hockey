require 'rails_helper'
require 'cancan/matchers'

describe "Abilities" do
  subject(:ability){ Ability.new(user) }
      
  let(:age_group){ FactoryGirl.create(:age_group) }
  let(:camp){ FactoryGirl.create(:camp, age_group: age_group) }
    
  let(:user_player){ FactoryGirl.create(:player) }
  let(:non_user_player){ FactoryGirl.create(:player) }

  context "when Guest" do
      let(:user){ nil }

    context "for Users" do
      it { should be_able_to(:create, User.new) }

      it { should_not be_able_to(:show, user) }
    end
    
    context "for Camps" do
      it { should_not be_able_to(:show, camp) }
    end

    context "for Coaches" do
    end

    context "for Players" do
      it { should_not be_able_to(:show, user_player) }
    end
  end

  let(:non_user){ FactoryGirl.create(:user, email: 'test3@example.com') }

  context "when User" do
    let(:user){ FactoryGirl.create(:user, email: 'test1@example.com') }

    context "for Users" do
      it { should be_able_to(:update, user) }
      it { should_not be_able_to(:update, non_user) }

      it { should be_able_to(:show, user) }
      it { should_not be_able_to(:show, non_user) }       
    end

    context "for Camps" do
      it { should_not be_able_to(:update, camp) }
      it { should_not be_able_to(:create, Camp.new) }
      it { should be_able_to(:show, camp)}
    end

    context "for Players" do
      it { should be_able_to(:update, user_player) }
      it { should_not be_able_to(:update, non_user_player) }
      
      it { should_not be_able_to(:create, Player.new) }

      it { should_not be_able_to(:index, Player.all) }
        
      it { should be_able_to(:show, user_player) }
      it { should_not be_able_to(:show, non_user_player) }
    end

  end

  context "when Admin" do
    let(:user){ FactoryGirl.create(:admin, email: 'test2@example.com') }
      
    context "for Users" do
      it { should be_able_to(:update, user) }
      it { should be_able_to(:update, non_user) }
      
      it { should be_able_to(:index, Player.all) }

      it { should be_able_to(:create, User.new) }

      it { should be_able_to(:show, user) }
      it { should be_able_to(:show, non_user) }
      
      it { should be_able_to(:destroy, non_user) }
    end
    
    context "for Camps" do
      it { should be_able_to(:update, camp) }
      
      it { should be_able_to(:index, Camp.all) }

      it { should be_able_to(:create, Camp.new) }

      it { should be_able_to(:show, camp) }

      it { should be_able_to(:publish, camp) }
      it { should be_able_to(:unpublish, camp) }
      
      it { should be_able_to(:destroy, camp) }
    end


    context "for Coaches" do
    end

    context "for Players" do
      it { should be_able_to(:update, user_player) }
      it { should be_able_to(:update, non_user_player) }

      it { should be_able_to(:index, Player.all) }

      it { should be_able_to(:create, Player.new) }

      it { should be_able_to(:show, user_player) }
      it { should be_able_to(:show, non_user_player) }

      it { should be_able_to(:destroy, user_player) }
      it { should be_able_to(:destroy, non_user_player) }
    end
  end
end