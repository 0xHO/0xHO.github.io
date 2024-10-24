# 所需工具
# brew install translate-shell

# 使用命令行创建文章
hugo-new-post(){
    _pwd=`pwd`
    cd ~blog
    post=`echo ${1}|tr '[:upper:]' '[:lower:]'`
    # 通过google翻译标题为英文，使用-联结仅保留的字母和数字
    postEn=`trans -brief :en "${post}"|awk '{ gsub(/[^a-zA-Z0-9]/, "-");gsub(/--/,"-");sub(/-+$/, ""); print tolower}'`
    day=`date "+%m%d"`
    mdFile="content/post/`date "+%y"`/${day}-${postEn}/index.md"
    # 创建文章
    hugo new content --kind default "${mdFile}"
    echo ${postEn}
    echo ~blog/${mdFile}
    cat ~blog/${mdFile} |sed  "s/${day}-${postEn}/${post}/g"|sed  "s/summary:/${post}/"|sed "s/slug: .*/slug: ${postEn}/g" &> ~blog/${mdFile}.1
    cat ~blog/${mdFile}.1 > ~blog/${mdFile}
    rm -rf ~blog/${mdFile}.1
    cd ${_pwd}
}