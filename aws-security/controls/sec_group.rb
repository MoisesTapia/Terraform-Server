# copyright: 2020, Moises Tapia
content = inspec.profile.file("terraform.json")
params = JSON.parse(content)

secgroup_name = params['secgroup_name']['value']
vpc_id        = params['vpc_id']['value']

title "Security Group"

control 'Check 03 - Security Group' do
  impact 1.0
  title 'Verify that SG'
  desc ''

  describe aws_security_group(group_name: secgroup_name, vpc_id: vpc_id ) do
    it { should exist }
    its ('outbound_rules.last') { should_not include(ip_ranges:['0.0.0.0/0']) }
    it { should allow_in(from_port: 80, to_port: 80, ipv4_range: '10.6.7.0/24') }
  end

  describe aws_security_group(group_name: secgroup_name, vpc_id: vpc_id ) do
    it { should exist }
    its ('outbound_rules.last') { should_not include(ip_ranges:['0.0.0.0/0']) }
    it { should allow_in(port: 80, ipv4_range: '10.5.0.0/16') }
    it { should allow_in(from_port: 22, to_port: 22, ipv4_range: '10.6.7.0/24') }
  end


end
