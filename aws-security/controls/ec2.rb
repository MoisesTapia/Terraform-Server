# copyright: 2020, The Authors

content = inspec.profile.file("terraform.json")
params = JSON.parse(content)


instance_id   = params['instance_id']['value']
instance_ami  = params['instance_ami']['value']
av_zone       = params['av_zone']['value']
vpc_id        = params['vpc_id']['value']
secgroup_ids   = params['secgroup_id']['value']

title "Verify EC2 Instance"

control "Check 01 - Insyance EC2 Exist" do
  impact 1.0
  title 'Intance EC2 Exist and has all propiertirs'
  describe aws_ec2_instance(instance_id) do
    it                          { should exist }
    it                          { should be_running }
    it                          { should_not have_roles }
    its ('image_id')            { should eq instance_ami }
    its ('availability_zone')   { should eq av_zone }
    its ('security_group_ids')  { should include secgroup_ids }
    its ('vpc_id')              { should eq vpc_id }

  end
end


