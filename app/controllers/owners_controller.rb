class OwnersController < ApplicationController

  get '/owners' do
    @owners = Owner.all
    erb :'/owners/index'
  end

  get '/owners/new' do
    @pets=Pet.all
    erb :'/owners/new'
  end

  post '/owners' do
     @owner = Owner.create(params[:owner])
    if !params["pet"]["name"].empty?
       @owner.pets << Pet.create(name: params["pet"]["name"])
    end
    @owner.save
    redirect "owners/#{@owner.id}"
  end

  get '/owners/:id/edit' do
    @owner = Owner.find(params[:id])
    @pets = @owner.pets
    erb :'/owners/edit'
  end

  get '/owners/:id' do
    @owner = Owner.find(params[:id])
    erb :'/owners/show'
  end

  patch '/owners/:id' do

    @owner=Owner.find(params[:id])
    @owner.update(params["owner"])
    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name:params["pet"]["name"])
    else
        @pet = Pet.find_by_id(params["owner"]["pet_ids"])
        if !@owner.pets.include?(@pet)
             @owner.pets << @pet
        end
        @pet
    end
    @owner.save
    redirect "owners/#{@owner.id}"
  end
end
