cat scripts/local/format.tbl .ob.tmp > /tmp/.gmon.tmp

echo '.TE' >> /tmp/.gmon.tmp

cat /tmp/.gmon.tmp | tbl |groff -Tlatin1|grep -v '^$'
