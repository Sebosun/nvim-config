function Find_typescript()
  local nodePackageLocation = vim.fn.system('npm root -g')
  --[[ assumes cli is in english ]]
  --[[ its dumb but will work for me hehe ]]
  --[[ "~/.nvm/versions/node/v16.19.1/lib/node_modules/typescript/lib/tsserverlibrary.js" ]]
  local potentialPath = nodePackageLocation .. 'typescript/lib/tsserverlibrary.js'

  if(os.execute('ls ' .. potentialPath) == 0) then
    return true, potentialPath
  end
  print(nodePackageLocation)

  return nil, potentialPath
end

