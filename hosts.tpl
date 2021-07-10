[build_servers]
%{ for ip in build_servers ~}
${ip}
%{ endfor ~}