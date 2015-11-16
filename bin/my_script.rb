require 'addressable/uri'
require 'rest-client'

def get_index
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users.html'
  ).to_s

  puts RestClient.get(url)
end

def post_create
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users.html',
    query_values: {
      'some_category[a_key]' => 'another value',
      'some_category[a_second_key]' => 'yet another value',
      'some_category[inner_inner_hash][key]' => 'value',
      'something_else' => 'aaahhhhh'
    }
  ).to_s

  body = {something: 'red'}
  puts RestClient.post(url, body)     # takes 2 to 3 arguments
  #{"something"=>"red", "some_category"=>{"a_key"=>"another value", "a_second_key"=>"yet another value", "inner_inner_hash"=>{"key"=>"value"}}, "something_else"=>"aaahhhhh", "controller"=>"users", "action"=>"create", "format"=>"html"}
end

def get_show
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users/3',
    query_values: {
      'first_key' => 'first_value',
      'nested_hash_key[nested_first_key]' => 'nested_first_value',
      'nested_hash_key[nested_sec_key]' => 'nested_sec_value'
    }
  ).to_s

  puts RestClient.get(url)
end



#=====================================================================

def create_user(attributes)

  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users.json'
  ).to_s

  begin   # RestClient will raise an exception if server sends a non 200 status
    restclientpost = RestClient.post(url, attributes)
  rescue RestClient::Exception => e
    puts e.message
  end

  puts restclientpost

end

def show_user(id)

  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: "/users/#{id}"    # beware string interpolation -- ""
  ).to_s

  puts RestClient.get(url)
end

def update_user(id, attributes)
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: "/users/#{id}"    # beware string interpolation -- ""
  ).to_s

  puts RestClient.patch(url, attributes)
end

def destroy_user(id)
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: "/users/#{id}"    # beware string interpolation -- ""
  ).to_s

  puts RestClient.delete(url)  #url contains id parameters
end

# update_user( 1, { user: {username: 'gina' } } ) # doesn't need all required attributes
# update_user( 2, { user: {username: 'peter' } } )
# update_user( 3, { user: {username: 'gizmo' } } )
# #destroy_user(4)

def update_contact(id, attributes)
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: "/contacts/#{id}"    # beware string interpolation -- ""
  ).to_s

  puts RestClient.patch(url, attributes)
end

# update_contact(2, :contact => {:email => 'pete@gmail.com'})

#create_user(:user => {:username => 'john'})
def create_contact(attributes)
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/contacts'
  ).to_s

  puts RestClient.post(url, attributes)
end

create_contact(:contact => {:user_id => 5, :name => 'John', :email => 'john@john.com'})
