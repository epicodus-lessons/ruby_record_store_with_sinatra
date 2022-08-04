require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('create an album path', {:type => :feature}) do
  it('creates an album and then goes to the album page') do
    visit('/albums')
    click_on('Add a new album')
    fill_in('album_name', :with => 'Yellow Submarine')
    click_on('Create!')
    expect(page).to(have_content('Yellow Submarine'))
  end
end

describe('edit an album path', {:type => :feature}) do
  it('creates an album and then goes to the album page') do
    visit('/albums')
    click_on('Add a new album')
    fill_in('album_name', :with => 'Kaleidoscope')
    click_on('Create!')
    click_on('Kaleidoscope')
    click_on('Edit album')
    fill_in('name', :with => 'From Mars to Sirius')
    click_on('Update')
    expect(page).to(have_content('From Mars to Sirius'))
  end
end

describe('delete an album path', {:type => :feature}) do
  it('creates an album and then goes to the album page') do
    visit('/albums')
    click_on('Add a new album')
    fill_in('album_name', :with => 'In Rainbows')
    click_on('Create!')
    click_on('In Rainbows')
    click_on('Edit album')
    click_on('Delete album')
    expect(page).not_to(have_content('In Rainbows'))
  end
end

describe('create a song path', {:type => :feature}) do
  it('creates a song and then goes to the album page') do
    album = Album.new({:name => "Yellow Submarine", :id => nil})
    album.save
    visit("/albums/#{album.id}")
    fill_in('song_name', :with => 'All You Need Is Love')
    click_on('Add song')
    expect(page).to(have_content('All You Need Is Love'))
  end
end

describe('update a song path', {:type => :feature}) do
  it('creates a song and then goes to the album page') do
    album = Album.new({:name => "Yellow Submarine", :id => nil})
    album.save
    visit("/albums/#{album.id}")
    fill_in('song_name', :with => 'All You Need Is Love')
    click_on('Add song')
    click_on('All You Need Is Love')
    fill_in('name', :with => 'Love Is All You Need')
    click_on('Update song')
    expect(page).to(have_content('Love Is All You Need'))
  end
end

describe('delete a song path', {:type => :feature}) do
  it('creates a song and then goes to the album page') do
    album = Album.new({:name => "Yellow Submarine", :id => nil})
    album.save
    visit("/albums/#{album.id}")
    save_and_open_page
    fill_in('song_name', :with => 'All You Need Is Love')
    click_on('Add song')
    fill_in('song_name', :with => 'All You Need Is Love')
    click_on('All You Need Is Love')
    click_on('Delete song')
    expect(page).not_to(have_content('All You Need Is Love'))
  end
end