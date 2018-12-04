/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   2_day1.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: bwan-nan <bwan-nan@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/12/03 17:04:01 by bwan-nan          #+#    #+#             */
/*   Updated: 2018/12/04 21:36:25 by bwan-nan         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <unistd.h>
#include <stdlib.h>
#include "../../libft/libft.h"
#include <fcntl.h>
#include "day1_part2.h"

static int			ft_intchr(int *tab, int frequency, int len)
{
	int i;

	i = 0;
	while (i < len)
	{
		if (tab[i] == frequency)
			return (1);
		i++;
	}
	return (0);
}

int					main(int ac, char **av)
{
	char		*line;
	int			*tmp;
	int			*tab;
	int			change;
	int			frequency;
	int			fd;
	int			i;
	int			stop;

	frequency = 0;
	i = 1;
	if (!tab)
	{
		if (!(tab = (int *)malloc(sizeof(int) * 1)))
			return (-1);	
		tab[0] = 0;
	}
	if (ac == 2)
	{
		fd = open(av[1], O_RDONLY);
		while (get_next_line(fd, &line))
		{
			change = ft_atoi(line);
			frequency += change;
			if (!tmp)
			{
				tmp = tab;
				if (!(tab = (int *)malloc(sizeof(int) * (i + 1))))
					return (-1);
				ft_memcpy(tab, tmp, sizeof(tab));
				tab[i] = frequency;
			}
			else
			{
				tmp = tab;
				if (!(tab = (int *)malloc(sizeof(int) * (i + 1))))
					return (-1);
				ft_memcpy(tab, tmp, sizeof(*tmp));
				tab[i] = frequency;
				free(tmp);
			}
			if (ft_intchr(tab, tab[i], i))
			{
				ft_putnbr(tab[i]);
				ft_putchar('\n');
				return (1);
			}
			ft_putnbr(tab[i]);
			ft_putchar('\n');
		}
		i++;
	}
	return (0);
}
