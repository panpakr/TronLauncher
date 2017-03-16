local backStack = {}

function backStack:push(scene)

  table.insert( backStack ,scene )

end

function backStack:pop()

  table.remove( backStack ,#backStack)

end

function backStack:peek()

  return backStack[#backStack-1]

end

function backStack:display()

  for i = 1,#backStack do

    print("Scenes backStack" .. backStack[i])
  end
end

return backStack
