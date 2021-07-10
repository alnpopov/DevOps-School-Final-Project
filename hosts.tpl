[build_servers]
%{ for ip in build_servers ~}
${ip}
%{ endfor ~}
[stage_servers]
%{ for ip in stage_servers ~}
${ip}
%{ endfor ~}