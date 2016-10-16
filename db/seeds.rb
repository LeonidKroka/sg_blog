def posts_title
  ["Libero finibus",
   "Viverra tincidunt",
   "Duis imperdiet",
   "Morbi sit",
   "lacus quam"]
end

def posts_body
  ["Donec eget libero finibus, auctor justo in, bibendum ipsum. Vivamus eu enim
    convallis, sodales sapien at, ornare est. Nulla commodo, arcu id pellentesque
    sagittis, dolor sem gravida ante, sit amet efficitur urna mi eget diam.
    Aliquam tincidunt neque ante, a mollis dolor euismod id. Pellentesque luctus
    erat turpis, eu semper felis ornare non. Aenean ut nisl fermentum, dictum
    ligula vel, condimentum lectus. Mauris vel luctus diam. Ut molestie, nibh
    eu lectus. Nulla nec odio eu enim mattis accumsan a volutpat nunc. Sed at
    odio justo. Mauris velit libero, consequat ut ultrices ut, luctus quis est.",

   "Aenean scelerisque hendrerit sapien viverra tincidunt. Nulla viverra congue
    finibus. Donec vestibulum nunc non erat elementum iaculis. Suspendisse eget
    orci lacinia, sagittis quam ut, placerat turpis. Sed gravida placerat leo,
    consectetur tincidunt elit blandit vel. Curabitur non nisl vitae lectus
    aliquet laoreet congue at ligula. Nunc a turpis id ipsum ultricies dapibus.
    Vestibulum sagittis pulvinar nisl ac dapibus. Fusce lobortis pharetra nisi,
    sed sodales turpis consectetur id. Nulla facilisi.",

   "Duis imperdiet, leo tempus cursus cursus, purus lacus convallis turpis, id
    tristique mauris elit sed nunc. Donec pharetra eleifend lacus vitae mattis.
    Suspendisse ut dapibus felis, aliquam efficitur dui. Nulla non scelerisque
    dui, sit amet ullamcorper risus. Nulla non purus eu elit maximus tincidunt
    a sit amet dui. Aliquam rutrum finibus diam eget rutrum. Suspendisse ac
    pharetra ex, at elementum nisi. Fusce interdum tortor metus, at convallis
    massa venenatis nec.",

   "Aliquam erat volutpat. Morbi sit amet magna non massa posuere efficitur at
    eget ex. Nullam sodales sed orci vel mollis. Quisque sit amet finibus arcu.
    Nullam blandit diam ut odio blandit scelerisque. Curabitur ac malesuada dui.
    Vestibulum non leo urna. In varius quam at metus tempus congue. Nullam
    venenatis vestibulum diam quis rhoncus. Vestibulum eget fringilla nibh,
    laoreet fringilla turpis. Phasellus porta dolor ac massa vulputate, vitae
    tincidunt nulla luctus.",

   "Cras nec lacus quam. Phasellus venenatis sodales massa nec vestibulum. Morbi
    ultrices ligula id enim tincidunt, id sodales mi sagittis. Vivamus bibendum
    velit nisi, sed mattis ex mattis quis. Curabitur at urna tincidunt dui
    feugiat congue. Nam quis lectus eu lorem mollis vulputate. Donec ultrices
    dapibus tellus, at tristique enim ultricies eget."]
end

def comments_body
  ["What is it?",
   "+100500",
   "I do not understand the author",
   "What am I doing here?",
   "Very nice"]
end

ActiveRecord::Base.connection.execute("DELETE FROM posts")
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence where name='posts'")
ActiveRecord::Base.connection.execute("DELETE FROM comments")
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence where name='comments'")
5.times do |n|
  Post.create(title: posts_title[n-1], body: posts_body[n-1])
  15.times {|m| Post.all[n].comments.create(:body => comments_body.sample)}
end
