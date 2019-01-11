/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   2_day6.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: bwan-nan <bwan-nan@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/01/11 13:32:07 by bwan-nan          #+#    #+#             */
/*   Updated: 2019/01/11 14:01:25 by bwan-nan         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"
#include "day6.h"
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>

static void		display_map(char **map)
{
	int i;

	i = 0;
	while (map[i])
		ft_putendl(map[i++]);
}

static int		get_manhattan_distance(int x, int y, int to_x, int to_y)
{
	int y_distance;
	int x_distance;

	y_distance = to_y - y;
	if (y_distance < 0)
		y_distance *= -1;
	x_distance = to_x - x;
	if (x_distance < 0)
		x_distance *= -1;
	return (y_distance + x_distance);
}

static int		area_size(char **map)
{
	int		i;
	int		j;
	int		area_size;

	j = 0;
	area_size = 0;
	while (map[j])
	{
		i = 0;
		while (map[j][i])
		{
			if (map[j][i] == '#')
				area_size++;
			i++;
		}
		j++;
	}	
	return (area_size);
}

static void		fill_map(char **map, t_point *points_list)
{
	int			i;
	int			j;
	int			min_dist;
	int			dist;
	char		char_to_write;
	t_point		*elem;

	j = 0;
	while (map[j])
	{
		i = 0;
		while (map[j][i])
		{
			dist = 0;
			elem = points_list;
			while (elem)
			{
				dist += get_manhattan_distance(i, j, elem->x, elem->y);
				//	printf("%d ", dist);
				elem = elem->next;
			}
			//	printf("i = %d j = %d min_dist = %d\n", i, j, min_dist);
			if (dist < 10000)
				map[j][i] = '#';
			i++;
		}
		j++;
	}
}

static void		update_map(char **map, t_point *points_list)
{
	t_point *elem;

	elem = points_list;
	while (elem)
	{
		//printf("y = %d ; x = %d\n", elem->y, elem->x);
		map[elem->y][elem->x] = elem->element_number + 64;
		elem = elem->next;
	}
}

static t_point	*create_point(char *line, int count)
{
	t_point *new_point;

	if (!(new_point = (t_point *)malloc(sizeof(t_point))))
		return (NULL);
	new_point->x = ft_atoi(line);
	new_point->y = ft_atoi(ft_strchr(line, ',') + 1);
	new_point->element_number = count; 
	new_point->next = NULL;
	return (new_point);
}

static void		load_point(t_point **points_list, char *line, int count)
{
	t_point *tmp;

	if (*points_list == NULL)
		*points_list = create_point(line, count);
	else
	{
		tmp = *points_list;
		while (tmp->next)
			tmp = tmp->next;
		tmp->next = create_point(line, count);
	}
}

static void		read_input(char *input, char **map)
{
	int		fd;
	char	*line;
	int		count;
	t_point	*points_list;

	line = NULL;
	count = 0;
	points_list = NULL;
	fd = open(input, O_RDONLY);
	while (get_next_line(fd, &line))
	{
		count++;
		load_point(&points_list, line, count);
		ft_strdel(&line);
	}
	update_map(map, points_list);
	fill_map(map, points_list);
	display_map(map);
	ft_putnbr(area_size(map));
	ft_putchar('\n');
	close(fd);
}

int				main(int ac, char **av)
{
	char	**map;
	int		i;

	if (ac == 2)
	{
		if (!(map = malloc(sizeof(char *) * 355)))
			return (-1);	
		i = 0;
		while (i < 355)
		{
			if (!(map[i] = ft_strnew(354)))
				return (-1);
			ft_memset(map[i], '.', 354);
			i++;
		}
		map[355] = 0;
		read_input(av[1], map);
	}
	else
		ft_putendl("usage: ./p2 day6_input.txt");
	return (0);
}
