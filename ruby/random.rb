def random_group
  # グループ分け用フラグ
  grouping = ['half', 'bias']
  members = ['A', 'B', 'C', 'D', 'E', 'F']
  group_divide = grouping.shuffle
  group_members = members.shuffle

  case group_divide[0]
  when 'half'
    p group_members[0..2]
    p group_members[3..5]
  when 'bias'
    p group_members[0..1]
    p group_members[2..5]
  end
end

random_group
