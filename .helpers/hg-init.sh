
pushd  /home/hg

if [[ ! -e repos ]] ; then
    if [[ -d '/ext-hdd/data' ]] ; then
        mkdir -p '/ext-hdd/data/hg/repos'
        ln -s    '/ext-hdd/data/hg/repos'
    else
        mkdir -p 'repos'
    fi
fi

popd

pushd  /home/hg/repos

for dir in  \
        DocViewTemplate     \
        FileTransWork       \
        GitModuleTest       \
        HouseholdAccounts   \
        LibraryTemplate     \
        Score4              \
        Settings            \
        gnupg               \
; do
    if [[ -d "${dir}/.hg" ]] ; then
        continue
    fi
    hg init "${dir}"
    hg init "Unconv-${dir}"
done

popd
