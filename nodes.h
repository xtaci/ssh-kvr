struct node_list {
	char * name;
	char * ip;
	struct list_head list;
};

static inline int node_init(struct node_list * mylist)
{
	INIT_LIST_HEAD(&mylist->list);
}


static inline int node_add(struct node_list * mylist, const char * name , const char * ip)
{
	struct node_list * tmp;
	tmp = (struct node_list *)malloc (sizeof(struct node_list));
	tmp->name = name;
	tmp->ip = ip;

	list_add(&(tmp->list), &(mylist->list));
}

static inline int node_list(struct node_list * mylist)
{
	struct list_head *pos, *q;
	struct node_list * tmp;
	
	list_for_each(pos, &mylist->list){
		tmp = list_entry(pos, struct node_list, list);
		printf("%s --> %s\n", tmp->name, tmp->ip);
	}
}
