describe "Application 'cdq_sums'" do
  before do
    @app = UIApplication.sharedApplication
    CDQ.cdq.reset!
    CDQ.cdq.setup
  end

  after do
    CDQ.cdq.reset!
  end

  def create_three_rows
    (1..3).each do |ii|
      date = DateFormatter.dateFromString("2015-06-0#{ii} 00:00:00 +0000")
      Weather.create date: date, inches: "#{ii}.5", inches_f: "#{ii}.5".to_f, month: '2015-06', readings: ii
    end
    CDQ.cdq.save
  end

  it "starts with nothing" do
    Weather.count.should == 0
  end

  it "can create three rows of test data" do
    create_three_rows
    Weather.count.should == 3
  end

  it "can fetch three rows of test data" do
    create_three_rows
    Weather.all.array.count.should == 3
  end

  it "can sort by date and enumerate with each" do
    create_three_rows
    array = []
    Weather.sort_by(:date).each {|weather| array << weather.readings }
    array.count.should == 3
    array.should == [ 1, 2, 3 ]
  end

  it "can sort by integer and enumerate with each" do
    create_three_rows
    array = []
    Weather.sort_by(:readings).each {|weather| array << weather.readings }
    array.count.should == 3
    array.should == [ 1, 2, 3 ]
  end

  it "can fetch the first row" do
    create_three_rows
    Weather.sort_by(:date).first.readings.should == 1
  end

  it "can fetch the last row" do
    create_three_rows
    Weather.sort_by(:date).last.readings.should == 3
  end

  it "can manually sum column of integers" do
    create_three_rows
    Weather.sort_by(:readings).inject(0) {|v, w| v += w.readings }.should == 6
  end

  it "can manually sum column of floats" do
    create_three_rows
    Weather.sort_by(:readings).inject(0.0) {|v, w| v += w.inches_f }.should == 7.5
  end

  # Maybe I don't know what I'm doing?
  it "can select row via equality operation - by applying :first" do
    create_three_rows
    Weather.where(:readings).eq(3).first.readings.should == 3
  end

  # Maybe I don't know what I'm doing?
  it "should raise error accessing an object selected via equality operator without applying :first" do
    create_three_rows
    ->{ Weather.where(:readings).eq(3).readings }.should.raise(NoMethodError)
  end

  it "can select sum of integers" do
    create_three_rows
    Weather.sum(:readings).should == 6
  end

  it "can select sum of floats" do
    create_three_rows
    Weather.sum(:inches_f).should == 7.5
  end

  it "can select average of integers" do
    create_three_rows
    Weather.average(:readings).should == 2
  end

  it "can select min of integers" do
    create_three_rows
    Weather.min(:readings).should == 1
  end

  it "can select max of integers" do
    create_three_rows
    Weather.max(:readings).should == 3
  end

  it "can map rows to floats" do
    create_three_rows
    Weather.sort_by(:inches_f).map {|w| w.inches_f}.should == [ 1.5, 2.5, 3.5 ]
  end

  it "can select rows having more than 2 readings" do
    create_three_rows
    Weather.sort_by(:inches_f).select {|w| w.readings > 2}.map {|w| w.readings}.should == [ 3 ]
  end

  it "can reject rows having more than 2 readings" do
    create_three_rows
    Weather.sort_by(:inches_f).reject {|w| w.readings > 2}.map {|w| w.readings}.should == [ 1, 2 ]
  end

  it "can reject rows having more than 2 readings, in reverse" do
    create_three_rows
    reversed = []
    Weather.sort_by(:inches_f).reverse_each {|w| reversed << w}
    reversed.reject {|w| w.readings > 2}.map {|w| w.readings}.should == [ 2, 1 ]
  end

  # Maybe I don't know what I'm doing?
  it "can apply index [] operator to select rows" do
    create_three_rows
    array  = []
    array << Weather[0]
    array << Weather[1]
    array << Weather[-1]
    array.inject(0) {|v, w| v += w.readings}.should == 6
  end

  # Maybe I don't know what I'm doing?
  it "can apply index [] operator to select rows sorted" do
    create_three_rows
    array  = []
    array << Weather.sort_by(:readings)[0]
    array << Weather.sort_by(:readings)[1]
    array << Weather.sort_by(:readings)[-1]
    array.inject(0) {|v, w| v += w.readings}.should == 6
  end
end
