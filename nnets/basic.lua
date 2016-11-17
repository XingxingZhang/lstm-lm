
require 'torch'

local BModel = torch.class('BModel')

function BModel:__init()
  self.name = 'Basic Model, name needed!'
end

function BModel:save(modelPath, saveOpts)
  if not modelPath:ends('.t7') then
    modelPath = modelPath .. '.t7'
  end
  
  if self.params:type() == 'torch.CudaTensor' then
    torch.save(modelPath, self.params:float())
  else
    torch.save(modelPath, self.params)
  end
  
  if saveOpts then
    local optPath = modelPath:sub(1, -4) .. '.state.t7'
    torch.save(optPath, self.opts)
  end
end

function BModel:load(modelPath)
  self.params:copy( torch.load(modelPath) )
end

function BModel:setModel(params)
  self.params:copy(params)
end

function BModel:getModel(outModel)
  return outModel:copy(self.params)
end

function BModel:print(msg)
  if msg == nil then
    xprint('the model is [%s]\n', self.name)
  else
    xprintln('[%s] %s', self.name, msg)
  end
end


