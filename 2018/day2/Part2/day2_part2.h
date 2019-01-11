/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   day2_part2.h                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: bwan-nan <bwan-nan@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/12/07 12:18:52 by bwan-nan          #+#    #+#             */
/*   Updated: 2019/01/11 13:59:45 by bwan-nan         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef DAY2_PART2_H
# define DAY2_PART2_H
# include "libft.h"

typedef struct 		s_box
{
	char			*box_name;
	struct s_box	*next;
}					t_box;

#endif
