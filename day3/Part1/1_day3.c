/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   1_day3.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: bwan-nan <bwan-nan@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/12/1000 20:40:31 by bwan-nan          #+#    #+#             */
/*   Updated: 2018/12/19 18:28:50 by bwan-nan         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../../libft/libft.h"
#include <fcntl.h>
#include <stdlib.h>
#include <unistd.h>
/*
static void		display_map(char **map)
{
	int i;

	i = 0;
	while (map[i])
	{
		ft_putendl(map[i]);
		i++;
	}
}*/

static int		count_overlaps(char **map)
{
	int i;
	int j;
	int count;

	count = 0;
	j = 0;
	while (map[j])
	{
		i = 0;
		while (map[j][i])
		{
			if (map[j][i] == 'X')
				count++;
			i++;
		}
		j++;
	}
	return (count);
}

static void		delete_map(char **map)
{
	int i;

	i = 0;
	while (map[i])
	{
		free(map[i]);
		i++;
	}
}

static void		update_map(char **map, char *str)
{
	int x_offset;
	int y_offset;
	int width;
	int height;
	int i;
	int j;

	x_offset = ft_atoi(ft_strchr(str, '@') + 1);
	y_offset = ft_atoi(ft_strchr(str, ',') + 1);
	width = ft_atoi(ft_strchr(str, ':') + 1);
	height = ft_atoi(ft_strchr(str, 'x') + 1);
	j = 0;
	while (j < height)
	{
		i = 0;
		while (i < width)
		{
			if (map[y_offset + j][x_offset + i] != '.')
				map[y_offset + j][x_offset + i] = 'X';
			else
				map[y_offset + j][x_offset + i] = '#';
			i++;
		}
		j++;
	}
}

static void		read_input(char *input, char **map)
{
	int	fd;
	char	*line;

	line = NULL;
	fd = open(input, O_RDONLY);
	while (get_next_line(fd, &line))
	{
		update_map(map, line);
		ft_strdel(&line);
	}
	close(fd);
	ft_putnbr(count_overlaps(map));
	ft_putchar('\n');

}

int			main(int ac, char **av)
{
	char	**map;
	int	i;

	if (ac == 2)
	{
		if (!(map = ft_memalloc(sizeof(char *) * 1000)))
			return (-1);
		i = 0;
		while (i < 1000)
		{
			if (!(map[i] = ft_memalloc(sizeof(char) * 1000)))
				return (-1);
			ft_memset(map[i], '.', 1000);
			map[i][999] = '\0';
			i++;
		}
		map[999] = 0;
		read_input(av[1], map);
		//display_map(map);
		delete_map(map);
	}
	return (0);
}
