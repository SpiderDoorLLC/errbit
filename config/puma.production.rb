rails_env = "production"
environment rails_env

# Change to match your CPU core count
workers ENV.fetch("PUMA_WORKERS") { 2 }

# Min and Max threads per worker
threads ENV.fetch("PUMA_MIN_THREADS") { 1 }, ENV.fetch("PUMA_MAX_THREADS") { 10 }

app_dir = "/home/ubuntu/errbit"
directory app_dir
# Set up socket location
bind "unix://#{app_dir}/puma.sock"

# Redirect STDOUT to log files
stdout_redirect "#{app_dir}/log/puma.stdout.log", "#{app_dir}/log/puma.stderr.log", true

# Set master PID and state locations
pidfile "#{app_dir}/puma.pid"
state_path "#{app_dir}/puma.state"
rackup "#{app_dir}/config.ru"

activate_control_app "unix://#{app_dir}/pumactl.sock"
