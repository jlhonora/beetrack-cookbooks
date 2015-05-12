node[:deploy].each do |application, deploy|
  swap_size = node['swap_size'] || 500
  script 'create swapfile' do
    interpreter 'bash'
    not_if { File.exists?('/mnt/swap') }
    code <<-eof
    dd if=/dev/zero of=/mnt/swap bs=1M count=#{swap_size} &&
    chmod 600 /mnt/swap &&
    mkswap /mnt/swap
    eof
  end

  mount '/dev/null' do  # swap file entry for fstab
    action :enable  # cannot mount; only add to fstab
    device '/mnt/swap'
    fstype 'swap'
  end

  script 'activate swap' do
    interpreter 'bash'
    code 'swapon -a'
  end
end
