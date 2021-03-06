case node[:platform_family]
when "debian"
  default[:canvasweb][:dir]        = "/mnt/i1-ebs/app/canvasproject/canvas.presentation/app"
  default[:canvasapp][:dir]        = "/mnt/i2-ebs/app/canvasproject/canvas.services/modules/aerospike"
  default[:canvasappconfig][:dir]  = "/mnt/i2-ebs/app/canvasproject/canvas.services/config"
else
  Chef::Log.error "Cannot configure nginx, platform unknown"
end
