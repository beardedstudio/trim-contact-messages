describe 'Trim::ContactSubject' do

  it 'should require name' do
    m = Trim::ContactSubject.make
    m.name = nil

    m.should_not be_valid
  end

  it 'should require email' do
    m = Trim::ContactSubject.make
    m.email = nil

    m.should_not be_valid
  end

  it 'should allow valid emails' do
    m = Trim::ContactSubject.make

    m.should be_valid
  end

  it 'should not allow invalid emails' do
    m = Trim::ContactSubject.make
    m.email = 'blarghle'

    m.should_not be_valid
  end

end
