case node[:platform_family]
when "debian"
  default[:canvasweb][:dir]        = "/mnt/canvas/app/current/canvas.presentation/app"
  default[:canvasapp][:dir]        = "/mnt/canvas/app/current/canvas.services/modules/aerospike"
  default[:canvasappconfig][:dir]  = "/mnt/canvas/app/current/canvas.services/config"
else
  Chef::Log.error "Cannot configure nginx, platform unknown"
end
