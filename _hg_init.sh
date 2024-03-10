
pushd  /home/hg

for dir in  \
        DocViewTemplate     \
        FileTransWork       \
        HouseholdAccounts   \
        Score4              \
        Settings            \
        gnupg               \
; do
    hg init ${dir}
done

popd
