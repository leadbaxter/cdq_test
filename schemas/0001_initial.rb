
schema "0001 initial" do
  entity 'Weather' do
    datetime  :date,     optional: false
    string    :inches,   optional: false
    string    :month,    optional: true   # filled in automatically
    float     :inches_f, optional: true   # filled in automatically
    integer32 :readings, optional: true
  end
end
