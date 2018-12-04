/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   2_day1.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: bwan-nan <bwan-nan@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/12/03 17:04:01 by bwan-nan          #+#    #+#             */
/*   Updated: 2018/12/04 12:17:31 by bwan-nan         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <unistd.h>
#include <stdlib.h>
#include "../../libft/libft.h"
#include <fcntl.h>
#include "day1_part2.h"

static t_flist		*lstcreate(int frequency, int change)
{
	t_flist	*new_flist;
	if (!(new_flist = (t_flist *)malloc(sizeof(t_flist))))
		return (NULL);
	new_flist->frequency = frequency;
	new_flist->change = change;
	new_flist->next = NULL;
	return (new_flist);
}

static void			load_flist(t_flist **flist, int frequency, int change)
{
	t_flist	*tmp;

	if (*flist)
	{
		tmp = *flist;
		while (tmp->next)
			tmp = tmp->next;
		tmp->next = lstcreate(frequency, change);
	}
}

int					main(int ac, char **av)
{
	t_flist		*flist;
	t_flist		**ptr;
	t_flist		**head;
	t_flist		**head2;
	t_flist		**tail;
	char		**tab;
	char		*line;
	int			*new_tab;
	int			frequency;
	int			fd;
	int			change;

	flist = NULL;
	frequency = 0;
	flist = lstcreate(frequency, change);
	head = &flist;
	if (ac == 2)
	{
		fd = open(av[1], O_RDONLY);
		while (get_next_line(fd, &line))
		{
			ptr = &flist;
			change = ft_atoi(line);
			frequency += change;
			while (*ptr)
			{
				if ((*ptr)->frequency == frequency)
				{
					ft_putnbr(frequency);
					ft_putchar('\n');
					close(fd);
					return (0);
				}
				(*ptr) = (*ptr)->next;
			}
			load_flist(ptr, frequency, change);
		}
		close(fd);
	/*	*tail = *ptr;
		while (1)
		{
			frequency += (*ptr)->frequency;
			(*head2) = (*head);
			while (*head2)
			{
				if ((*head2)->frequency == frequency)
				{
					ft_putnbr(frequency);
					ft_putchar('\n');
					close(fd);
					return (0);
				}
				(*head2) = (*head2)->next;
			}
			load_flist(tail, frequency, (*ptr)->change);
			(*ptr) = (*ptr)->next;
			*tail = (*tail)->next;
		}*/
	}
	ft_putnbr(frequency);
	return (0);
}
