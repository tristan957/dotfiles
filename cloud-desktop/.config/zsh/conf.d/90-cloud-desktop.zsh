# if you wish to use IMDS set AWS_EC2_METADATA_DISABLED=false
export AWS_EC2_METADATA_DISABLED=true

export BRAZIL_WORKSPACE_DEFAULT_LAYOUT=short

# On Cloud Desktop, use fish
if command -v fish &>/dev/null; then
    exec fish --login
fi
