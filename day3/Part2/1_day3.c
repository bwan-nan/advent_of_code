/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   1_day3.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: bwan-nan <bwan-nan@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/12/1000 20:40:31 by bwan-nan          #+#    #+#             */
/*   Updated: 2018/12/17 19:25:09 by bwan-nan         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../../libft/libft.h"
#include "day3.h"
#include <fcntl.h>
#include <stdlib.h>
#include <unistd.h>

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
	t_claim	*claims_list;

	line = NULL;
	claims_list = NULL;
	fd = open(input, O_RDONLY);
	while (get_next_line(fd, &line))
	{
		load_claim(&claims_list, line);
		update_map(map, line);
		ft_strdel(&line);
	}
	close(fd);
	ft_putnbr(find_the_one(claims_list, map));
	ft_putchar('\n');
	del_claims_list(claims_list);

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
			map[i][1000] = '\0';
			i++;
		}
		map[1000] = 0;
		read_input(av[1], map);
		delete_map(map);
	}
	return (0);
}
