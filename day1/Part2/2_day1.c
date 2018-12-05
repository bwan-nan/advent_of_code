/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   2_day1.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: bwan-nan <bwan-nan@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/12/03 17:04:01 by bwan-nan          #+#    #+#             */
/*   Updated: 2018/12/05 21:33:33 by bwan-nan         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include "../../libft/libft.h"
#include <fcntl.h>
#include "day1_part2.h"

static void		show_tab(int *tab, int len)
{
	int i;

	i = 0;
	while (i < len)
	{
		ft_putnbr(i);
		ft_putstr("  ");
		ft_putnbr(tab[i]);
		ft_putchar('\n');
		i++;
	}
}

static int		ft_intchr(int *tab, int frequency, int len)
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

static void		create_tab(char *str, int i)
{
	int		*movements;
	int		*new_tab;
	int		fd;
	int		movement;
	int		frequency;
	int		k;
	char		*line;
	int		*tmp;
	int		stop;

	movement = 0;
	if (!movements)
	{
		if (!(movements = (int *)malloc(sizeof(int) * 1)))
			return ;	
		movements[0] = 0;
	}
	fd = open(str, O_RDONLY);
	while (get_next_line(fd, &line))
	{
		movement = ft_atoi(line);
		tmp = movements;
		if (!(movements = malloc(sizeof(int) * (i + 1))))
			return ;
		ft_memcpy(movements, tmp, sizeof(int) * i);
		free(tmp);
		movements[i] = ft_atoi(line);

		i++;
	}
	k = i;
	stop = k;
	i = 1;
	new_tab = ft_memalloc(sizeof(int) * (k + 1));
	new_tab[0] = 0;
	while (i < k + 1)
	{
		new_tab[i] = new_tab[i - 1] + movements[i - 1];
		i++;
	}
	i = 0;
	while (i < ++k)
	{
		if (i == stop)
			i = 0;
		tmp = new_tab;
		if (!(new_tab = malloc(sizeof(int) * (k + 1))))
			return ;
		ft_memcpy(new_tab, tmp, sizeof(int) * k);
		free(tmp);
		new_tab[k] = new_tab[k - 1] + movements[i];
		if (ft_intchr(new_tab, new_tab[k], k))
		{
			ft_putnbr(new_tab[k]);
			ft_putstr("\n");
			free(new_tab);
			free(movements);
			return ;
		}
		i++;
	}
}

int			main(int ac, char **av)
{
	if (ac == 2)
		create_tab(av[1], 0);
	return (0);
}
