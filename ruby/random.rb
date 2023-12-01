def random_group
  
  members = ['A', 'B', 'C', 'D', 'E', 'F']
  group_members = members.shuffle

  random = Random.new
  i = random.rand(1..2)

  p group_members[0..i].sort
  p group_members[i + 1..5].sort
end

random_group
