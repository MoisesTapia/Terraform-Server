# copyright: 2020, Moises Tapia

content = inspec.profile.file("terraform.json")
params = JSON.parse(content)

vpc_id        = params['aws_instance']['value']

title "Verify the VPC"


# You add controls here
# Only run this control if the `aws_vpc_id` attribute is provided.
control "Check 02 - vpc-exists" do

    only_if { aws_vpc_id == vpc_id }
    impact 1.0
    title "Check to see if custom VPC exists."
    desc '--------------'

    describe aws_vpc(aws_vpc_id) do
        it                       { should exist }
        it                       { should be_default }
        its ('cidr_block')       { should cmp '201.141.44.213/32' }
        its ('state')            { should eq 'available' }
        its ('instance_tenancy') { should eq vpc_id }

    end
end