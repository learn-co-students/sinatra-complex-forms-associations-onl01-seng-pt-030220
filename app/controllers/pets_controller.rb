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
  @pet = Pet.create(name:params[:pet_name]) 
  if params[:owner_name].empty?
  @pet.owner_id = params[:pet][:owner_id][0]
  owner = Owner.find(params[:pet][:owner_id][0])
  owner.pets << @pet
  else
  new_owner= Owner.create(name:params[:owner_name])
  new_owner.pets << @pet
  @pet.owner_id = new_owner.id
  end
  redirect "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
  @pet = Pet.find(params[:id])
  erb :'/pets/show'
  end

  get '/pets/:id/edit' do 
  @pet = Pet.find(params[:id])
  @pet_owner = Owner.all
  erb :'/pets/edit'
  end

  patch '/pets/:id' do 
  @pet = Pet.find(params[:id])
  @pet.update(name:params[:pet_name])
  if params[:owner][:name].empty?
    @pet.owner_id = params[:existing][:id]
    new_owner=Owner.find(params[:existing][:id]) 
    new_owner.pets << @pet
  else
    new_owner = Owner.create(name:params[:owner][:name])
    new_owner.pets << @pet 
    @pet.owner_id = new_owner.id
  end
  redirect to "pets/#{@pet.id}"
  end
end