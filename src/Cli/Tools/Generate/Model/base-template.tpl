<?= '<?php'; ?>

declare(strict_types=1);

namespace <?= $namespace; ?>\Base;

use Imi\Model\Model;
use Imi\Model\Annotation\DDL;
use Imi\Model\Annotation\Table;
use Imi\Model\Annotation\Column;
use Imi\Model\Annotation\Entity;

/**
 * <?= $tableComment; ?> 基类
 * <?php if (true === $entity):?>@Entity<?php else:?>@Entity(false)<?php endif; ?>

 * @Table(name="<?= $table['name']; ?>"<?php if (isset($table['id'][0])):?>, id={<?= '"', implode('", "', $table['id']), '"'; ?>}<?php endif; ?><?php if ($poolName):?>, dbPoolName="<?=$poolName; ?>"<?php endif; ?>)
 * @DDL("<?= str_replace('"', '""', $ddl); ?>")
<?php foreach ($fields as $field):?>
 * @property <?= $field['phpType']; ?> $<?= $field['varName']; ?> <?= '' === $field['comment'] ? '' : $field['comment']; ?>

<?php endforeach; ?>
 */
abstract class <?= $className; ?>Base extends Model
{
<?php
    foreach ($fields as $field):
?>
    /**
<?php if ('' === $field['comment']):?>
     * <?= $field['name']; ?>
<?php else: ?>
     * <?= $field['comment']; ?>

     * <?= $field['name']; ?>
<?php endif; ?>

     * @Column(name="<?= $field['name']; ?>", type="<?= $field['type']; ?>", length=<?= $field['length']; ?>, accuracy=<?= $field['accuracy']; ?>, nullable=<?= json_encode($field['nullable']); ?>, default="<?= $field['default']; ?>", isPrimaryKey=<?= json_encode($field['isPrimaryKey']); ?>, primaryKeyIndex=<?= $field['primaryKeyIndex']; ?>, isAutoIncrement=<?= json_encode($field['isAutoIncrement']); ?>)
     * @var <?= $field['phpType']; ?>

     */
    protected <?= $field['phpType']; ?> $<?= $field['varName']; ?>;

    /**
     * 获取 <?= $field['varName']; ?><?= '' === $field['comment'] ? '' : (' - ' . $field['comment']); ?>

     *
     * @return <?= $field['phpType']; ?>

     */ 
    public function get<?= ucfirst($field['varName']); ?>(): <?= $field['phpType']; ?>
    {
        return $this-><?= $field['varName']; ?>;
    }

    /**
     * 赋值 <?= $field['varName']; ?><?= '' === $field['comment'] ? '' : (' - ' . $field['comment']); ?>

     * @param <?= $field['phpType']; ?> $<?= $field['varName']; ?> <?= $field['name']; ?>

     * @return static
     */ 
    public function set<?= ucfirst($field['varName']); ?>(<?= $field['phpType']; ?> $<?= $field['varName']; ?>)
    {
        $this-><?= $field['varName']; ?> = $<?= $field['varName']; ?>;
        return $this;
    }

<?php
    endforeach;
?>
}