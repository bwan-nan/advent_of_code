/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   2_day1.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: bwan-nan <bwan-nan@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/12/03 17:04:01 by bwan-nan          #+#    #+#             */
/*   Updated: 2018/12/03 19:30:47 by bwan-nan         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <unistd.h>
#include <stdlib.h>
#include "../../libft/libft.h"
#include <fcntl.h>
#include "day1_part2.h"

static t_flist		*lstcreate(int frequency)
{
	t_flist	*new_flist;
	if (!(new_flist = (t_flist *)malloc(sizeof(t_flist))))
		return (NULL);
	new_flist->frequency = frequency;
	new_flist->next = NULL;
	return (new_flist);
}

static void			load_flist(t_flist **flist, int frequency)
{
	t_flist	*tmp;

	if (*flist == NULL)
		*flist = lstcreate(0);
	else
	{
		tmp = *flist;
		while (tmp->next)
			tmp = tmp->next;
		tmp->next = lstcreate(frequency);
	}
}

int					main(int ac, char **av)
{
	t_flist		*flist;
	t_flist		**ptr;
	t_flist		**head;
	char		**tab;
	char		*line;;
	int			*new_tab;
	int			frequency;
	int			count;
	int			fd;

	flist = NULL;
	flist = lstcreate(frequency);
	*head = flist;
	frequency = 0;
	count = 0;
	if (ac == 2)
	{
		fd = open(av[1], O_RDONLY);
		while (get_next_line(fd, &line))
		{
			count++;
			ptr = &flist;
			frequency += ft_atoi(line);
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
			load_flist(&flist, frequency);
		}
		if (get_next_line(fd, &line) == 0)
		{
			while (*ptr)
				(*ptr) = (*ptr)->next;
			(*ptr)->next = *head;
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
		}
		close(fd);
	}
	return (0);
}
