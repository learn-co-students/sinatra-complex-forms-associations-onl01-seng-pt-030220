class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    @pet = Pet.create(name: params[:pet_name])
    if params[:owner]
      @owner = Owner.find(params[:owner][:id])
      @pet.update(owner: @owner)
    end
    if !params[:owner_name].empty?
      @new_owner = Owner.create(name: params[:owner_name])
      @pet.update(owner: @new_owner)
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @owners = Owner.all
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  patch '/pets/:id' do 
    @pet = Pet.find(params[:id])
    @pet.update(name: params[:pet_name])
    if params[:owner][:id] != @pet.owner.id
      @pet.update(owner: Owner.find(params[:owner][:id]))
    end
    if !params[:owner][:name].empty?
      @owner = Owner.create(name: params[:owner][:name])
      @pet.update(owner: @owner)
    end
    redirect to "pets/#{@pet.id}"
  end
end