/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   1_day6.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: bwan-nan <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/12/18 15:15:24 by bwan-nan          #+#    #+#             */
/*   Updated: 2019/01/03 11:38:26 by bwan-nan         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../../libft/libft.h"
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

static int		find_biggest_area(char **map, t_point *points_list)
{
	t_point *elem;
	int		i;
	int		j;
	int		count;
	int		largest_area;

	largest_area = 0;
	elem = points_list;
	while (elem)
	{
		count = 0;
		j = 0;	
		while (map[j])
		{
			if (j == 0 || j == 353)
			{
				if (ft_strchr(map[j], elem->element_number + 64))
					break ;
			}
			if (map[j][0] == elem->element_number + 64 || map[j][353] == elem->element_number + 64)
				break ;
			i = 0;
			while (map[j][i])
			{
				if (map[j][i] == elem->element_number + 64)
					count++;
				i++;
			}
			j++;
		}
		if (count > largest_area)
		{
			largest_area = count;
			ft_putnbr(largest_area);
			ft_putchar('\n');
		}
		elem = elem->next;
	}
	return (largest_area);
}

static void		fill_map(char **map, t_point *points_list)
{
	int			i;
	int			j;
	int			min_dist;
	int			dist;
	int			char_to_write;
	t_point		*elem;

	j = 0;
	while (map[j])
	{
		i = 0;
		while (map[j][i])
		{
			elem = points_list;
			while (elem)
			{
				dist = get_manhattan_distance(i, j, elem->x, elem->y);
				//	printf("%d ", dist);
				if (elem->element_number == 1 || dist < min_dist)
				{
					char_to_write = elem->element_number + 64;
					min_dist = dist;
				}
				else if (dist == min_dist)
					char_to_write = '.';	
				elem = elem->next;
			}
			//	printf("i = %d j = %d min_dist = %d\n", i, j, min_dist);
			map[j][i] = char_to_write;
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
	ft_putnbr(find_biggest_area(map, points_list));
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
		ft_putendl("My input contained a mistake, so the answer was 2906 and not 5037");
	}
	return (0);
}
