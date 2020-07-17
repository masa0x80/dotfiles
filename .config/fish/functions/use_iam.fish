function use_iam
    export (aws-vault exec $IAM_PROFILE -- env | grep AWS_ | grep -v AWS_VAULT)
end
