/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   2_day2.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: bwan-nan <bwan-nan@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/12/07 12:11:23 by bwan-nan          #+#    #+#             */
/*   Updated: 2019/01/03 11:25:52 by bwan-nan         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "day2_part2.h"
#include <fcntl.h>
#include <stdlib.h>
#include <unistd.h>

/*
   static void			print_list(t_box *boxes_list)
   {
   while (boxes_list)
   {
   ft_putendl(boxes_list->box_name);
   boxes_list = boxes_list->next;
   }
   }*/

static void			lstdel(t_box **list)
{
	while (*list)
	{
		ft_strdel(&((*list)->box_name));
		*list = (*list)->next;
	}
	free(*list);
	(void)(*list);
}

static int			count_differences(char *a, char *b)
{
	int		i;
	int		count;

	i = 0;
	count = 0;
	while (a[i])
	{
		if (a[i] != b[i])
			count++;
		i++;
	}
	return (count);
}

static int			find_the_one(t_box **boxes_list)
{
	t_box		*elem;
	t_box		*list;

	elem = *boxes_list;
	while (elem)
	{
		list = elem;
		while (list)
		{
			if (count_differences(list->box_name, elem->box_name) == 1)
			{
				ft_putendl(list->box_name);
				ft_putendl(elem->box_name);
				lstdel(boxes_list);
				return (1);	
			}
			list = list->next;
		}
		elem = elem->next;
	}
	return (0);
}

static t_box		*create_box(char *str)
{
	t_box *new_box;

	if (!(new_box = (t_box *)malloc(sizeof(t_box))))
		return (NULL);
	new_box->box_name = str;
	new_box->next = NULL;
	return (new_box);
}

static	void		load_box(t_box **boxes_list, char *box_name)
{
	t_box *tmp;

	if (*boxes_list == NULL)
		*boxes_list = create_box(box_name);
	else
	{
		tmp = *boxes_list;
		while (tmp->next)
			tmp = tmp->next;
		tmp->next = create_box(box_name);
	}
}

static void		read_file(char *str)
{
	int		fd;
	char	*line;
	t_box	*boxes_list;

	boxes_list = NULL;
	line = NULL;
	fd = open(str, O_RDONLY);
	while (get_next_line(fd, &line))
		load_box(&boxes_list, line);
	close(fd);
	find_the_one(&boxes_list);
	//print_list(boxes_list);
}

int				main(int ac, char **av)
{
	if (ac == 2)
		read_file(av[1]);
	else
		ft_putendl("usage: ./p2 day2_input.txt");
	return (0);
}
